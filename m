From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5] hwmon: pwm-fan: Add pwm-fan driver
Date: Wed, 16 Jul 2014 10:17:09 -0700
Message-ID: <20140716171709.GA10548@roeck-us.net>
References: <1405525602-30563-1-git-send-email-k.debski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1405525602-30563-1-git-send-email-k.debski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kamil Debski <k.debski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, t.figa@samsung.com, m.szyprowski@samsung.com, tklauser@distanz.ch, linux-pwm@vger.kernel.org, varkabhadram@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Jul 16, 2014 at 05:46:42PM +0200, Kamil Debski wrote:
> The pwm-fan driver enables control of fans connected to PWM lines.
> This driver uses the PWM framework, so it is compatible with all
> PWM devices that provide drivers through the PWM framework.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>
> Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Applied to -next, after fixing up the alignment at
devm_hwmon_device_register_with_groups.

Thanks,
Guenter
