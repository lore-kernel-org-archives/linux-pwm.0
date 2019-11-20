From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: Convert stm32 low power timers
 bindings to json-schema
Date: Wed, 20 Nov 2019 12:09:55 -0600
Message-ID: <20191120180955.GA22823@bogus>
References: <20191118094842.20171-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118094842.20171-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: fabrice.gasnier@st.com, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, 18 Nov 2019 10:48:42 +0100, Benjamin Gaignard wrote:
> Convert the STM32 low power timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in version 2:
> - improve counter function description
> - set reg maximum to 2 instead of 3
> 
>  .../bindings/counter/stm32-lptimer-cnt.txt         |  29 -----
>  .../bindings/iio/timer/stm32-lptimer-trigger.txt   |  23 ----
>  .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  | 120 +++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-lptimer.txt      |  48 ---------
>  .../devicetree/bindings/pwm/pwm-stm32-lp.txt       |  30 ------
>  5 files changed, 120 insertions(+), 130 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-lptimer-cnt.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-lptimer-trigger.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-lptimer.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32-lp.txt
> 

Applied, thanks.

Rob
