From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 02/16] pwm: pxa: update documentation regarding
 pwm-cells
Date: Fri, 19 Jan 2018 16:30:24 -0600
Message-ID: <20180119223024.m5kuc6467xmgkgac@rob-hp-laptop>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43392 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756582AbeASWa1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Jan 2018 17:30:27 -0500
Content-Disposition: inline
In-Reply-To: <1515766983-15151-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: thierry.reding@gmail.com, mark.rutland@arm.com, linux@armlinux.org.uk, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, corbet@lwn.net, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, Mike Dunn <mikedunn@newsguy.com>

On Fri, Jan 12, 2018 at 04:22:49PM +0200, Claudiu Beznea wrote:
> pwm-cells should be at least 2 to provide channel number and period value.
> 
> Cc: Mike Dunn <mikedunn@newsguy.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> index 5ae9f1e3c338..a0e20edeeebc 100644
> --- a/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> @@ -10,7 +10,7 @@ Required properties:
>    Note that one device instance must be created for each PWM that is used, so the
>    length covers only the register window for one PWM output, not that of the
>    entire PWM controller.  Currently length is 0x10 for all supported devices.
> -- #pwm-cells: Should be 1.  This cell is used to specify the period in
> +- #pwm-cells: Should be 2.  This cell is used to specify the period in
>    nanoseconds.

What's the new cell? channel? Does the PXA PWM have more than one 
channel? If not, then you shouldn't add a cell.

Rob
