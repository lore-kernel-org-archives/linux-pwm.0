From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: pwm-stm32: add #pwm-cells
Date: Tue, 9 Jul 2019 14:04:54 -0600
Message-ID: <20190709200454.GA328@bogus>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
 <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560937925-8990-2-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, alexandre.torgue@st.com, mark.rutland@arm.com, linux@armlinux.org.uk, mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, benjamin.gaignard@st.com, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

On Wed, 19 Jun 2019 11:52:01 +0200, Fabrice Gasnier wrote:
> STM32 Timers support generic 3 cells PWM bindings to encode PWM number,
> period and polarity as defined in pwm.txt.
> 
> Fixes: cd9a99c2f8e8 ("dt-bindings: pwm: Add STM32 bindings")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-stm32.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
