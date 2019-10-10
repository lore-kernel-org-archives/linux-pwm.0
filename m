From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: pwm: Convert Samsung PWM bindings to json-schema
Date: Thu, 10 Oct 2019 13:58:30 -0500
Message-ID: <CAL_Jsq+Fa1+epSvDpSx4NdzOUohoJR+qR3-xyMTTw4LaOK7AbQ@mail.gmail.com>
References: <20191002164047.14499-1-krzk@kernel.org> <20191002164047.14499-2-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002164047.14499-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-tegra@vger.kernel.org, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, linux-amlogic@lists.infradead.o
List-Id: linux-pwm@vger.kernel.org

On Wed, Oct 2, 2019 at 11:41 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Convert Samsung PWM (S3C, S5P and Exynos SoCs) bindings to DT schema
> format using json-schema.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v2:
> 1. Add additionalProperties: false.
>
> Changes since v1:
> 1. Indent example with four spaces (more readable),
> 2. Fix samsung,pwm-outputs after review,
> 3. Remove double-quotes from clock names.
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.txt   |  51 --------
>  .../devicetree/bindings/pwm/pwm-samsung.yaml  | 109 ++++++++++++++++++
>  2 files changed, 109 insertions(+), 51 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
