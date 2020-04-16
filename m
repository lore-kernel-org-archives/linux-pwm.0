From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 11/16] gpio: add support for the sl28cpld GPIO
 controller
Date: Thu, 16 Apr 2020 10:34:23 +0200
Message-ID: <CACRpkdbANL_W3gcTwue5VUCWT95boMXjFSqTeFDZvJ6iSeNpJg@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-12-michael@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200402203656.27047-12-michael@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michael Walle <michael@walle.cc>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@>
List-Id: linux-pwm@vger.kernel.org

Hi Michael,

this is looking good provided we can get the generic GPIO regmap
helper reviewed and merged. Thanks!

On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> wrote:

> This adds support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

> +       depends on MFD_SL28CPLD

Apart from this depends it seems the patch is compile-time
independent of the other patches so I'd suggest we just merge
the generic regmap driver and this driver to the GPIO tree once
we feel finished with them, optimistically assuming that the MFD
driver will land and that we will not need any fundamental
changes in the GPIO driver.

Worst case we have to revert the driver and that is no disaster.

Yours,
Linus Walleij
