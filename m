From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 04/16] dt-bindings: mfd: Add bindings for sl28cpld
Date: Tue, 28 Apr 2020 16:39:44 +0200
Message-ID: <8cc4a2bd3fcaf836d7f393ce2425c872@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-5-michael@walle.cc>
 <20200428124825.GT185537@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200428124825.GT185537@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Mark
List-Id: linux-pwm@vger.kernel.org

Am 2020-04-28 14:48, schrieb Andy Shevchenko:
> On Thu, Apr 23, 2020 at 07:45:31PM +0200, Michael Walle wrote:
>> This adds device tree bindings for the board management controller 
>> found
>> on the Kontron SMARC-sAL28 board.
> 
> I think it should be independent patches (same way as you do for 
> drivers).

It used to be several patches but Rob suggested to put it into one:
https://lore.kernel.org/linux-devicetree/20200330223535.GA31402@bogus/

-michael

> 
>>  .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  51 ++++++
>>  .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 +++
>>  .../bindings/mfd/kontron,sl28cpld.yaml        | 162 
>> ++++++++++++++++++
>>  .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
>>  .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
