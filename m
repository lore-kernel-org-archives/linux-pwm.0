From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 03/13] dt-bindings: mfd: Add bindings for sl28cpld
Date: Mon, 13 Jul 2020 10:04:27 -0600
Message-ID: <20200713160427.GA303616@bogus>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-4-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:44876 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQEb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jul 2020 12:04:31 -0400
Content-Disposition: inline
In-Reply-To: <20200706175353.16404-4-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Michael Walle <michael@walle.cc>
Cc: Li Yang <leoyang.li@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org, Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.o

On Mon, 06 Jul 2020 19:53:43 +0200, Michael Walle wrote:
> Add a device tree bindings for the board management controller found on
> the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - fix the regex of the unit-address
> 
> Changes since v3:
>  - see cover letter
> 
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

Reviewed-by: Rob Herring <robh@kernel.org>
