From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v10 15/18] dt-bindings: counter: ftm-quaddec
Date: Fri, 26 Apr 2019 09:10:27 -0500
Message-ID: <20190426141027.GA27110@bogus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org, david@lechnology.com, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de, thierry.reding@gmail.com, esben@haabendal.dk, linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, patrick.havelange@essensium.com
List-Id: linux-pwm@vger.kernel.org

On Tue, Apr 02, 2019 at 03:30:50PM +0900, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> FlexTimer quadrature decoder driver.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> new file mode 100644
> index 000000000000..4d18cd722074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> @@ -0,0 +1,18 @@
> +FlexTimer Quadrature decoder counter
> +
> +This driver exposes a simple counter for the quadrature decoder mode.
> +
> +Required properties:
> +- compatible:		Must be "fsl,ftm-quaddec".

This needs an SoC specific compatible.

> +- reg:			Must be set to the memory region of the flextimer.
> +
> +Optional property:
> +- big-endian:		Access the device registers in big-endian mode.
> +
> +Example:
> +		counter0: counter@29d0000 {
> +			compatible = "fsl,ftm-quaddec";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			big-endian;
> +			status = "disabled";

Don't show status in examples.

> +		};
> -- 
> 2.21.0
> 
