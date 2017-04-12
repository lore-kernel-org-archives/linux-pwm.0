From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2 1/1] pwm: pca9685: fix gpio-only operation.
Date: Wed, 12 Apr 2017 08:09:00 -0400
Message-ID: <CAGngYiXy+k0wwu23hoLB0rvB8j9P7hvAvoMeN_UA5A__AHD=dw@mail.gmail.com>
References: <1491938345-16933-1-git-send-email-svenv@arcx.com>
 <1491938345-16933-2-git-send-email-svenv@arcx.com> <20170412085350.GB29222@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170412085350.GB29222@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

On Wed, Apr 12, 2017 at 4:53 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> Looks like going to the right direction.

Thanks, I appreciate your comments !

>> +static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
> Why did you move the function here?

Because I added code that disables the output when the user releases
(unexports) the pwm or gpio.

If the output is not disabled on release (unexport):
- the output will remain in its previous state (possibly ON)
- when the last output is unexported, SLEEP is set, and all outputs
   are disabled at the same time
- this is counter-intuitive behaviour.

Expect a v3 patch soon which addresses your feedback.
