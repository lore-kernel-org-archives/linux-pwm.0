From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 04/24] dt-bindings: Add doc for the Ingenic TCU drivers
Date: Mon, 13 Aug 2018 09:24:22 -0600
Message-ID: <20180813152422.GA18650@rob-hp-laptop>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-5-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-5-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Lee Jones <lee.jones@linaro.org>, Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Aug 09, 2018 at 11:43:54PM +0200, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ----
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 134 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 ---
>  3 files changed, 134 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt

Reviewed-by: Rob Herring <robh@kernel.org>
