#pragma once

#include <contrib/ydb/core/tablet/tablet_counters.h>
#include <contrib/ydb/library/services/services.pb.h>
#include <contrib/ydb/public/api/protos/draft/persqueue_error_codes.pb.h>

#include <library/cpp/actors/core/actor.h>

namespace NKikimr {
namespace NPQ {

void ReplyPersQueueError(
    TActorId dstActor,
    const TActorContext& ctx,
    ui64 tabletId,
    const TString& topicName,
    TMaybe<ui32> partition,
    NKikimr::TTabletCountersBase& counters,
    NKikimrServices::EServiceKikimr service,
    const ui64 responseCookie,
    NPersQueue::NErrorCode::EErrorCode errorCode,
    const TString& error,
    bool logDebug = false
);

}// NPQ
}// NKikimr