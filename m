Return-Path: <tomasz.figa@gmail.com>
Return-Path: <tomasz.figa@gmail.com>
From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 4/4] Documentation: Add device tree bindings for Freescale FTM PWM
Date: Wed, 21 Aug 2013 21:30:04 +0200
Message-ID: <1473340.OXSHEp7d4P@flatron>
In-Reply-To: <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
References: <1377054462-6283-1-git-send-email-Li.Xiubo@freescale.com> <1377054462-6283-5-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pwm.vger.kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, thierry.reding@gmail.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linus.walleij@linaro.org

Hi Xiubo,

Please see my comments inline.

On Wednesday 21 of August 2013 11:07:42 Xiubo Li wrote:
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  .../devicetree/bindings/pwm/fsl-ftm-pwm.txt        | 52
> ++++++++++++++++++++++ 1 file changed, 52 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/pwm/fsl-ftm-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/fsl-ftm-pwm.txt
> b/Documentation/devicetree/bindings/pwm/fsl-ftm-pwm.txt new file mode
> 100644
> index 0000000..698965b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/fsl-ftm-pwm.txt
> @@ -0,0 +1,52 @@
> +Freescale FTM PWM controller
> +
> +Required properties:
> +- compatible: should be "fsl,vf610-ftm-pwm"
> +- reg: physical base address and length of the controller's registers
> +- #pwm-cells: Should be 3. Number of cells being used to specify PWM
> property.
> +  First cell specifies the per-chip channel index of the PWM
> to use, the 
> +  second cell is the period in nanoseconds and bit 0 in
> the third cell is 
> +  used to encode the polarity of PWM output. Set bit
> 0 of the third in PWM 
> +  specifier to 1 for inverse polarity & set to 0
> for normal polarity.

If the meaning of flags cell is the same as in generic, default PWM 
specifier format, then it should be noted here and generic PWM binding 
documentation mentioned. 

> +- fsl,pwm-clk-ps: the ftm0 pwm clock's prescaler,
> divide-by 2^n(n = 0 ~ 7).

Is it a hardware-specific property?

> +- fsl,pwm-cpwm: Center-Aligned PWM (CPWM)
> mode.

Could you explain meaning of this property?

> +- fsl,pwm-number: the number of PWM devices, and is must equal to the
> number +  of "fsl,pwm-channels".

This is redundant, because you can simply count how many entries have been 
specified in fsl,pwm-channels.

> +- fsl,pwm-channels: the channels' order which is be used for pwm in
> ftm0 +  module, and they must be one or some of 0 ~ 7, because the ftm0
> only has +  8 channels can be used.

Could you explain meaning of this property more precisely? I'm interested 
especially how is this related to the PWM IP block and boards.

> +- for very channel, the revlatived the pinctrl should be at least two
                           ^ typo?

> state +  {"enN", "dsN"}, which "en" means "enable", "ds" means
> "disable" and "N" +  means the order of the channel.

I'd suggest a more readable naming convention, for example chN-active and 
chN-idle. These words seem to be more common across existing bindings.

Best regards,
Tomasz
