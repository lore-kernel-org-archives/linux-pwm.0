From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] ARM: dts: NSP: Add PWM Support to DT
Date: Tue, 01 Mar 2016 21:25:54 +0100
Message-ID: <9193665.m7s4avOK78@wuerfel>
References: <1456854169-9788-1-git-send-email-yendapally.reddy@broadcom.com> <1456854169-9788-4-git-send-email-yendapally.reddy@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50747 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbcCAU0p (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Mar 2016 15:26:45 -0500
In-Reply-To: <1456854169-9788-4-git-send-email-yendapally.reddy@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On Tuesday 01 March 2016 12:42:49 Yendapally Reddy Dhananjaya Reddy wrote:
>                 };
>  
> +               pwm: pwm@31000 {
> +                       compatible = "brcm,iproc-pwm";
> +                       reg = <0x31000 0x28>;
> +                       clocks = <&osc>;
> +                       #pwm-cells = >;
> +                       status = "disabled";
> +               };
> 

Should this also list "brcm,kona-pwm" as compatible? From patch
1, it sounds like that was the original one.

	Arnd
