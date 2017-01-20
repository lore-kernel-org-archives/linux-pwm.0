From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v9 8/8] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-disco
Date: Fri, 20 Jan 2017 11:03:19 +0100
Message-ID: <77a0e229-1ab0-33f2-edf0-71efd76fdc4a@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: gerald.baeza@st.com, fabrice.gasnier@st.com, arnaud.pouliquen@st.com, Benjamin Gaignard <benjamin.gaignard@st.com>, linaro-kernel@lists.linaro.org
List-Id: linux-pwm@vger.kernel.org

Hi Benjamin,

On 01/20/2017 10:15 AM, Benjamin Gaignard wrote:
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 8a163d7..92552d3 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -81,3 +81,31 @@
>  &usart3 {
>  	status = "okay";
>  };
> +
> +&timers1 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm1_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer@0 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers3 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm3_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer@2 {
> +		status = "okay";
> +	};
> +};
>

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks
Alex
