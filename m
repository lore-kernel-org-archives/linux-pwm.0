From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v6 0/4] Fix bugs in kona pwm driver and pwm core
Date: Fri, 10 Apr 2015 13:51:30 -0700
Message-ID: <552837D2.3020304@broadcom.com>
References: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:37774 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365AbbDJUvp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Apr 2015 16:51:45 -0400
In-Reply-To: <1428692333-14400-1-git-send-email-jonathar@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan Richardson <jonathar@broadcom.com>, Tim Kryger <tim.kryger@gmail.com>, Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Arun Ramamurthy <arun.ramamurthy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org

Hi Jonathan,

Patcheset looks good.
Acked-by: Scott Branden <sbranden@broadcom.com>


On 15-04-10 11:58 AM, Jonathan Richardson wrote:
> This patchset fixes a number of bugs in the Broadcom Kona pwm driver. It also
> fixes a bug in the pwm core where the enabled state was incorrect on failed
> calls to enable. Also, a new function was added to the pwm core to add pwm chips
> with inversed polarity for chips that have a different default polarity than the
> core. The prevents incorrect polarity being reported.
>
> These changes are required for the Kona pwm driver to work on Cygnus and the
> same pwm IP is being used.
>
> Changes from v5:
>    - Address Dmitry's comment on code cleanup of pwm_enable() in pwm core.
>    - Including all patches from different contributors in this patchset. Some
> 	were left out in v4.
>
> Changes from v4:
>    - Rebased to Tim Kryger's patch that adds support in pwm core to add driver
>      with inversed polarity.
>    - Removed patch 2 that resolved difference between hardware default polarity
>      and pwm framework default polarity. The default polarity is set properly now
>      when the pwm driver is registered with the pwm framework.
>
> Arun Ramamurthy (1):
>    drivers: pwm: bcm-kona: Dont set polarity in probe
>
> Jonathan Richardson (2):
>    pwm: kona: Fix incorrect config, disable, and polarity procedures
>    pwm: core: Set enable state properly on failed call to enable
>
> Tim Kryger (1):
>    drivers: pwm: core: Add pwmchip_add_inversed
>
>   drivers/pwm/core.c         |   52 +++++++++++++++++++++------
>   drivers/pwm/pwm-bcm-kona.c |   84 +++++++++++++++++++++++++++++++++-----------
>   include/linux/pwm.h        |    6 ++++
>   3 files changed, 110 insertions(+), 32 deletions(-)
>

