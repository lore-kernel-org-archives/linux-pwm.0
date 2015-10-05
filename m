From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v7 3/5] ARM: berlin: add a PWM node on the BG2Q
Date: Mon, 05 Oct 2015 20:19:53 +0200
Message-ID: <5612BF49.6020607@gmail.com>
References: <1443797990-10809-1-git-send-email-antoine.tenart@free-electrons.com> <1443797990-10809-4-git-send-email-antoine.tenart@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443797990-10809-4-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>, thierry.reding@gmail.com
Cc: zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 02.10.2015 16:59, Antoine Tenart wrote:
> This patch adds a PWM node in the Berlin BG2Q device tree, using the
> newly added Berlin PWM driver.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)

Applied this and the next two for BG2 and BG2CD
to berlin/dt.

Thanks,
   Sebastian

> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 63a48490e2f9..5bfa71a87617 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -477,6 +477,13 @@
>   			status = "disabled";
>   		};
>
> +		pwm: pwm@f20000 {
> +			compatible = "marvell,berlin-pwm";
> +			reg = <0xf20000 0x40>;
> +			clocks = <&chip_clk CLKID_CFG>;
> +			#pwm-cells = <3>;
> +		};
> +
>   		apb@fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
>
