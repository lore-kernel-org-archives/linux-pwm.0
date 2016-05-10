From: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Subject: Re: [PATCH RESEND 0/3] pwm support for Broadcom iProc SoC's
Date: Tue, 10 May 2016 19:25:47 +0530
Message-ID: <CAL2FKYkxugMVsFaFugPNKWwBjpo+2Mkt4x+=c-OgU5PcsOqiuQ@mail.gmail.com>
References: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35425 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcEJNzs (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 10 May 2016 09:55:48 -0400
Received: by mail-io0-f172.google.com with SMTP id d62so16644252iof.2
        for <linux-pwm@vger.kernel.org>; Tue, 10 May 2016 06:55:48 -0700 (PDT)
In-Reply-To: <1459261350-23851-1-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Hi Thierry,

  Can you please provide review comments for this patch set.

Thanks
Dhananjay

On Tue, Mar 29, 2016 at 7:52 PM, Yendapally Reddy Dhananjaya Reddy
<yendapally.reddy@broadcom.com> wrote:
> This patchset contains the pwm support for the Broadcom's iProc SoC's.
>
> The first patch provides the documentation details and the
> second patch contains the controller support details. The third patch
> contains the enable method for Northstar Plus SoC.
>
> This patch series has been tested on NSP bcm958625HR board with oscilloscope.
> The pwm is not enabled for this board as the pins are open and not used.
>
> This patch series is based on v4.6.0-rc1 and is available from github
> repo: https://github.com/Broadcom/cygnus-linux.git
> branch: iproc-pwm-v1
>
> This patch series was originally sent on 03/01/16.
> See https://lkml.org/lkml/2016/3/1/487
>
> Yendapally Reddy Dhananjaya Reddy (3):
>   Documentation: dt: Add Broadcom iproc pwm controller binding
>   pwm: kona: Add support for Broadcom iproc pwm controller
>   ARM: dts: NSP: Add PWM Support to DT
>
>  .../devicetree/bindings/pwm/brcm,kona-pwm.txt      |   2 +-
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |   8 +
>  drivers/pwm/Kconfig                                |   6 +-
>  drivers/pwm/pwm-bcm-kona.c                         | 183 ++++++++++++++++++---
>  4 files changed, 172 insertions(+), 27 deletions(-)
>
> --
> 2.1.0
>
