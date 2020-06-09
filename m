From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 01/11] dt-bindings: mfd: Add bindings for sl28cpld
Date: Tue, 9 Jun 2020 10:28:30 -0600
Message-ID: <20200609162830.GA1019634@bogus>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-2-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200604211039.12689-2-michael@walle.cc>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Mark Brown <broonie@kernel.org>, linux-watchdog@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lee Jones <lee.jones@linaro.org>, Li Yang <leoyang.li@nxp.com>, linux-gpio@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>, Marc Zyngier <maz@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz
List-Id: linux-pwm@vger.kernel.org

On Thu, 04 Jun 2020 23:10:29 +0200, Michael Walle wrote:
> Add a device tree bindings for the board management controller found on
> the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
>  .../kontron,sl28cpld-intc.yaml                |  54 +++++++
>  .../bindings/mfd/kontron,sl28cpld.yaml        | 153 ++++++++++++++++++
>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
>  6 files changed, 358 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
>  create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
>  create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.example.dt.yaml: sl28cpld@4a: 'gpio@1a', 'gpio@1b', 'hwmon@b', 'interrupt-controller@1c', 'pwm@c', 'pwm@e' do not match any of the regexes: '^gpio(@[0-9]+)?$', '^hwmon(@[0-9]+)?$', '^interrupt-controller(@[0-9]+)?$', '^pwm(@[0-9]+)?$', '^watchdog(@[0-9]+)?$', 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1303780

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
