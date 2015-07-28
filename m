From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH 2/2] DT: pwm: Add NXP LPC18xx PWM/SCT binding documentation
Date: Wed, 29 Jul 2015 00:37:13 +0200
Message-ID: <CAGhQ9Vyy+oUAWm0q2+NV0D9RVf5qyED8Tn54-cGzbDc-EZR4yw@mail.gmail.com>
References: <1437972345-16444-1-git-send-email-ariel@vanguardiasur.com.ar>
	<1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33277 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbG1WhP (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2015 18:37:15 -0400
Received: by lbbyj8 with SMTP id yj8so84304010lbb.0
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2015 15:37:13 -0700 (PDT)
In-Reply-To: <1437972345-16444-3-git-send-email-ariel@vanguardiasur.com.ar>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Cc: linux-pwm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Thierry Reding <thierry.reding@gmail.com>

On 27 July 2015 at 06:45, Ariel D'Alessandro <ariel@vanguardiasur.com.ar> wrote:
> Add the devicetree binding document for NXP LPC18xx PWM/SCT.
>
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
> ---
>  .../devicetree/bindings/pwm/lpc1850-pwm.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
>
> diff --git a/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
> new file mode 100644
> index 0000000..3055429
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/lpc1850-pwm.txt
> @@ -0,0 +1,20 @@
> +* NXP LPC18xx Pulse Width Modulator driver
> +
> +Required properties:
> +  - compatible: Should be "nxp,lpc1850-pwm"
> +  - reg: Should contain physical base address and length of pwm registers.
> +  - clocks: Must contain an entry for each entry in clock-names.
> +    See ../clock/clock-bindings.txt for details.
> +  - clock-names: Must include the following entries.
> +    - pwm: PWM operating clock.
> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for the description
> +    of the cells format.
> +
> +Example:
> +  pwm: pwm@40000000 {
> +    compatible = "nxp,lpc1850-pwm";

I would prefer "nxp,lpc1850-sct" for a couple of reasons. SCT is the
name of hardware block as described in the user manual and while PWM
is the most obvious usage for this block on Linux, the hardware is not
limited to just doing that. So as a bit of future proofing if someone
wants to use this block for more than PWM I would prefer SCT.


> +    reg = <0x40000000 0x580>;

Please map the entire memory block as noted in the user manual, ie. 0x1000.


regards,
Joachim Eastwood
