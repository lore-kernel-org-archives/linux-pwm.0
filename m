From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH v8 1/5] drivers: pwm: core: Add pwmchip_add_inversed
Date: Sun, 14 Jun 2015 17:51:35 -0700
Message-ID: <CAD7vxx+uUqB0KuGuLHNrEE64x9kJPYq6CeH6oXWQVRaRrzRANg@mail.gmail.com>
References: <1432670900-27687-1-git-send-email-jonathar@broadcom.com>
	<1432670900-27687-2-git-send-email-jonathar@broadcom.com>
	<20150612094509.GC19400@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34846 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbbFOAvh (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Jun 2015 20:51:37 -0400
In-Reply-To: <20150612094509.GC19400@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Richardson <jonathar@broadcom.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PWM <linux-pwm@vger.kernel.org>

On Fri, Jun 12, 2015 at 2:45 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, May 26, 2015 at 01:08:16PM -0700, Jonathan Richardson wrote:
>> From: Tim Kryger <tim.kryger@gmail.com>
>>
>> Add a new function to register a PWM chip with channels that have their
>> initial polarity as inversed.  This benefits drivers of controllers that
>> by default operate with inversed polarity by removing the need to modify
>> the polarity during initialization.
>>
>> Signed-off-by: Tim Kryger <tim.kryger@gmail.com>
>> Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
>> ---
>>  drivers/pwm/core.c  |   36 ++++++++++++++++++++++++++++--------
>>  include/linux/pwm.h |    6 ++++++
>>  2 files changed, 34 insertions(+), 8 deletions(-)
>
> I had to bikeshed this a little, so I ended up applying a variant that
> exports pwmchip_add_with_polarity() instead of having the additional
> wrapper. The rationale here is that pwmchip_add_with_polarity() is more
> explicit than pwmchip_add_inversed().
>
> Thierry

Sounds good.  Thanks.

-Tim
