From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] pwm-pca9685: Allow any of the 16 PWMs to be used as a
 GPIO
Date: Fri, 21 Oct 2016 15:23:41 +0300
Message-ID: <20161021122341.GV24289@lahna.fi.intel.com>
References: <20160920144056.130104-1-mika.westerberg@linux.intel.com>
 <20161019185638.GP1722@lahna.fi.intel.com>
 <20161020104541.GA25598@ulmo.ba.sec>
 <20161020111844.GB24289@lahna.fi.intel.com>
 <20161020125144.GA24653@ulmo.ba.sec>
 <20161020130117.GK24289@lahna.fi.intel.com>
 <20161020215009.GA2185@mithrandir.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37234 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754423AbcJUMXr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Oct 2016 08:23:47 -0400
Content-Disposition: inline
In-Reply-To: <20161020215009.GA2185@mithrandir.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-pwm@vger.kernel.org

On Thu, Oct 20, 2016 at 11:50:11PM +0200, Thierry Reding wrote:
> > I would then go for keeping the code in this single driver for now and
> > re-think this later if other drivers start to develop similar.
> 
> That's fine with me. I'll take a closer look at this patch and apply if
> I don't find anything out of place.

Thanks!
