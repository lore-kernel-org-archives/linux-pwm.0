From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pwm: Unexport children before chip removal
Date: Mon, 5 Sep 2016 17:03:51 +0200
Message-ID: <20160905150351.GB10308@kroah.com>
References: <1470779866-74776-1-git-send-email-davidhsu@google.com>
 <20160905144641.GR31424@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:50789 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932605AbcIEPDq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Sep 2016 11:03:46 -0400
Content-Disposition: inline
In-Reply-To: <20160905144641.GR31424@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: David Hsu <davidhsu@google.com>, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 05, 2016 at 04:46:41PM +0200, Thierry Reding wrote:
> On Tue, Aug 09, 2016 at 02:57:46PM -0700, David Hsu wrote:
> > Exported pwm channels aren't removed before the pwmchip and are
> > leaked. This results in invalid sysfs files. This fix removes
> > all exported pwm channels before chip removal.
> > 
> > Signed-off-by: David Hsu <davidhsu@google.com>
> > ---
> >  drivers/pwm/core.c  |  2 ++
> >  drivers/pwm/sysfs.c | 18 ++++++++++++++++++
> >  include/linux/pwm.h |  5 +++++
> >  3 files changed, 25 insertions(+)
> 
> I've applied this with the following added to the commit message:
> 
> 	Fixes: 76abbdde2d95 ("pwm: Add sysfs interface")
> 
> since this seems to have been wrong since forever.

Wonderful, thanks for doing that.

greg k-h
