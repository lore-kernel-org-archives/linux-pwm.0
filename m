From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: mfd: Convert stm32 timers bindings to
 json-schema
Date: Thu, 14 Nov 2019 11:31:29 -0600
Message-ID: <20191114173129.GA25237@bogus>
References: <20191114101823.23144-1-benjamin.gaignard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191114101823.23144-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com, fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, benjamin.gaignard@st.com, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 14 Nov 2019 11:18:23 +0100, Benjamin Gaignard wrote:
> Convert the STM32 timers binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 3:
> - correctly use enum for dma-names and remove additionalItems: true
> - provide a range of values for reg property
> 
> version 2:
> - merge all (mfd, iio, pwm, counter) bindings in one file
> - fix typo and trailing spaces
> - rework dmas and dma-names properties to allow schemas like:
>   ch1 , ch2, ch4
>   ch2, up, com
> - use patternProperties to describe timer subnode
> - improve st,breakinput property definition to be able to check the values
>   inside de tuple
> 
>  .../bindings/counter/stm32-timer-cnt.txt           |  31 ----
>  .../bindings/iio/timer/stm32-timer-trigger.txt     |  25 ----
>  .../devicetree/bindings/mfd/st,stm32-timers.yaml   | 159 +++++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt       |  73 ----------
>  .../devicetree/bindings/pwm/pwm-stm32.txt          |  38 -----
>  5 files changed, 159 insertions(+), 167 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> 

Applied, thanks.

Rob
