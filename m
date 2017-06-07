From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: hwmon: pwm-fan: switch to new atomic PWM API
Date: Wed, 7 Jun 2017 14:07:02 -0700
Message-ID: <20170607210057.GA29962@roeck-us.net>
References: <1493039598-25881-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170602132359epcas4p113157cdf641dae2e186c4ccd75432e00@epcas4p1.samsung.com>
 <20170602132353.GA12690@roeck-us.net>
 <2730680.la1ZiRyv91@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47514 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751299AbdFGVHE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jun 2017 17:07:04 -0400
Content-Disposition: inline
In-Reply-To: <2730680.la1ZiRyv91@amdc3058>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jean Delvare <jdelvare@suse.com>, Kamil Debski <kamil@wypas.org>, Tomasz Figa <tomasz.figa@gmail.com>, linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Wed, Jun 07, 2017 at 03:38:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday, June 02, 2017 06:23:53 AM Guenter Roeck wrote:
> > On Mon, Apr 24, 2017 at 03:13:17PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Switch pwm-fan driver to new atomic PWM API.
> > > 
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > ---
> > > Depends on "[PATCH v2 0/3] pwm: pwm-samsung: fix suspend/resume support"
> > > patchset (https://www.spinics.net/lists/kernel/msg2495209.html).
> > 
> > I lost track where we are with this patch. The above series set did not make
> > it, as far as I can see. Is this patch truly dependent on that series, or
> > can it be applied separately ? It does apply cleanly.
> 
> I think that it can be applied separately (the broken suspend/resume code
> will continue to use the old API until the previous patchset is finally
> merged and the code in question is removed altogether).
> 

Ok. Applied to hwmon-next.

Thanks,
Guenter
