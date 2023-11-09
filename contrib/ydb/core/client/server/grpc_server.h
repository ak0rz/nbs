#pragma once
#include <contrib/ydb/core/grpc_services/auth_processor/dynamic_node_auth_processor.h>

#include <contrib/ydb/core/protos/grpc.grpc.pb.h>

#include <library/cpp/actors/core/actorsystem.h>
#include <library/cpp/actors/core/actor_bootstrapped.h>
#include <library/cpp/grpc/server/grpc_server.h>
#include <contrib/ydb/public/lib/deprecated/client/grpc_client.h>
#include <contrib/ydb/public/lib/base/defs.h>
#include <contrib/ydb/public/lib/base/msgbus.h>

#include <util/thread/factory.h>
#include <util/generic/queue.h>

namespace NKikimr {

namespace NMsgBusProxy {
    class TBusMessageContext;
} // NMsgBusProxy

namespace NGRpcProxy {

//! State of current request. It allows to:
//!  - retrieve request's message;
//!  - send reply to caller.
class IRequestContext {
public:
    virtual ~IRequestContext() = default;

    //! Get pointer to the request's message.
    virtual const NProtoBuf::Message* GetRequest() const = 0;

    //! Send reply.
    virtual void Reply(const NKikimrClient::TResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TDsTestLoadResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TBsTestLoadResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TJSON& resp) = 0;
    virtual void Reply(const NKikimrClient::TNodeRegistrationResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TCmsResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TSqsResponse& resp) = 0;
    virtual void Reply(const NKikimrClient::TConsoleResponse& resp) = 0;

    //! Send error reply when request wasn't handled properly.
    virtual void ReplyError(const TString& reason) = 0;

    //! Bind MessageBus context to the request.
    virtual NMsgBusProxy::TBusMessageContext BindBusContext(int type) = 0;

    virtual TVector<TStringBuf> FindClientCert() const = 0;

    //! Returns peer address
    virtual TString GetPeer() const = 0;
};

//! Implements interaction Kikimr via gRPC protocol.
class TGRpcService
    : public NGrpc::TGrpcServiceBase<NKikimrClient::TGRpcServer>
{
public:
    TGRpcService();

    void SetDynamicNodeAuthParams(const TDynamicNodeAuthorizationParams& dynamicNodeAuthorizationParams) {
        DynamicNodeAuthorizationParams = dynamicNodeAuthorizationParams;
    }

    void InitService(grpc::ServerCompletionQueue* cq, NGrpc::TLoggerPtr logger) override;
    void SetGlobalLimiterHandle(NGrpc::TGlobalLimiter* limiter) override;

    NThreading::TFuture<void> Prepare(NActors::TActorSystem* system, const NActors::TActorId& pqMeta, const NActors::TActorId& msgBusProxy, TIntrusivePtr<::NMonitoring::TDynamicCounters> counters);
    void Start();

    bool IncRequest();
    void DecRequest();
    i64 GetCurrentInFlight() const;

private:
    void RegisterRequestActor(NActors::IActor* req);

    //! Setup handlers for incoming requests.
    void SetupIncomingRequests();

private:
    using IThreadRef = TAutoPtr<IThreadFactory::IThread>;


    NActors::TActorSystem* ActorSystem;
    NActors::TActorId PQMeta;
    NActors::TActorId MsgBusProxy;

    grpc::ServerCompletionQueue* CQ = nullptr;

    size_t PersQueueWriteSessionsMaxCount = 1000000;
    size_t PersQueueReadSessionsMaxCount  = 100000;

    TIntrusivePtr<::NMonitoring::TDynamicCounters> Counters;

    std::function<void()> InitCb_;
    // In flight request management.
    NGrpc::TGlobalLimiter* Limiter_ = nullptr;

    TDynamicNodeAuthorizationParams DynamicNodeAuthorizationParams = {};
};

}
}