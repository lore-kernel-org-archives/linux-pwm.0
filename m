From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Thu, 1 Dec 2016 09:28:18 +0200
Message-ID: <20161201072818.GL1459@lahna.fi.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
 <20161020130117.GK24289@lahna.fi.intel.com>
 <20161020215009.GA2185@mithrandir.ba.sec>
 <20161021122341.GV24289@lahna.fi.intel.com>
 <20161031114256.GN23812@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34697 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbcLAH2X (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Dec 2016 02:28:23 -0500
Content-Disposition: inline
In-Reply-To: <20161031114256.GN23812@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Mon, Oct 31, 2016 at 01:42:56PM +0200, Mika Westerberg wrote:
> On Fri, Oct 21, 2016 at 03:23:41PM +0300, Mika Westerberg wrote:
> > On Thu, Oct 20, 2016 at 11:50:11PM +0200, Thierry Reding wrote:
> > > > I would then go for keeping the code in this single driver for now and
> > > > re-think this later if other drivers start to develop similar.
> > > 
> > > That's fine with me. I'll take a closer look at this patch and apply if
> > > I don't find anything out of place.
> > 
> > Thanks!
> 
> Hi Thierry,
> 
> Did you get a chance to look at the patch?

Just a friendly reminder as we are getting closer to v4.9 release and
merge window opens soon.
