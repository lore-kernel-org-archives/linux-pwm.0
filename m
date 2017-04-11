From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: fix gpio-only operation.
Date: Tue, 11 Apr 2017 12:11:26 +0300
Message-ID: <20170411091126.GP2957@lahna.fi.intel.com>
References: <1491754284-3870-1-git-send-email-svenv@arcx.com>
 <1491754284-3870-2-git-send-email-svenv@arcx.com>
 <20170410103320.GG2957@lahna.fi.intel.com>
 <CAGngYiVpWa9qrTFn9BmTahgyBZDsX22vjfjL=4JZUMV9W+nxmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGngYiVpWa9qrTFn9BmTahgyBZDsX22vjfjL=4JZUMV9W+nxmw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Apr 10, 2017 at 11:35:39PM -0400, Sven Van Asbroeck wrote:
> > How about implementing a real runtime PM in the driver? Then when the
> > device is idle regardless of whether it is GPIO or PWM, the SLEEP bit is
> > set and cleared accordingly.
> 
> You mean: increase the runtime_pm refcnt when a pwm/gpio is enabled,
> and vice versa ? And don't touch the refcnt on pwm/gpio export/unexport?

I mean whenever the thing is in use, it is in runtime PM active state.
Then when the last user closes the device, it goest to runtime PM
suspend state where you effectively set that SLEEP bit. The functions
for refcounting are called pm_runtime_get* and pm_runtime_put*.

You need to implement runtime PM callbacks for the driver as well.

See Documentation/power/runtime_pm.txt for more information.
