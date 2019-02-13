From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] pwm: sifive: Add DT documentation for SiFive PWM
 Controller
Date: Wed, 13 Feb 2019 14:37:52 -0600
Message-ID: <20190213203752.GA18326@bogus>
References: <1550049978-20705-1-git-send-email-yash.shah@sifive.com>
 <1550049978-20705-2-git-send-email-yash.shah@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550049978-20705-2-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: palmer@sifive.com, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, thierry.reding@gmail.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sachin.ghadi@sifive.com, paul.walmsley@sifive.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 13, 2019 at 02:56:17PM +0530, Yash Shah wrote:
> DT documentation for PWM controller added.
> 
> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> [Atish: Compatible string update]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sifive.txt         | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sifive.txt b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> new file mode 100644
> index 0000000..3b9c64c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sifive.txt
> @@ -0,0 +1,30 @@
> +SiFive PWM controller
> +
> +Unlike most other PWM controllers, the SiFive PWM controller currently only
> +supports one period for all channels in the PWM. All PWMs need to run at
> +the same period. The period also has significant restrictions on the values
> +it can achieve, which the driver rounds to the nearest achievable period.
> +PWM RTL that corresponds to the IP block version numbers can be found
> +here:
> +
> +https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/pwm
> +
> +Required properties:
> +- compatible: Should be "sifive,$socname-pwm" and "sifive,pwmX".
> +  Please refer to sifive-blocks-ip-versioning.txt for details.

Please specify what soc and IP version are used. Is sifive,pwm10 valid?

> +- reg: physical base address and length of the controller's registers
> +- clocks: Should contain a clock identifier for the PWM's parent clock.
> +- #pwm-cells: Should be 3. See pwm.txt in this directory
> +  for a description of the cell format.
> +- interrupts: one interrupt per PWM channel
> +
> +Examples:
> +
> +pwm:  pwm@10020000 {
> +	compatible = "sifive,fu540-c000-pwm", "sifive,pwm0";
> +	reg = <0x0 0x10020000 0x0 0x1000>;
> +	clocks = <&tlclk>;
> +	interrupt-parent = <&plic>;
> +	interrupts = <42 43 44 45>;
> +	#pwm-cells = <3>;
> +};
> -- 
> 1.9.1
> 
