From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Mon, 3 Mar 2014 12:53:11 +0300
Message-ID: <20140303095311.GF27552@mwanda>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
 <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
 <000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
 <CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
 <1393391957.407.1.camel@joe-AO722>
 <CAKohpokrSZiHAUoQggEnnYADUpE2DSBA0ECoUfPZPZFxTha3CA@mail.gmail.com>
 <008e01cf367d$e926a6b0$bb73f410$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23875 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbaCCJxf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Mar 2014 04:53:35 -0500
Content-Disposition: inline
In-Reply-To: <008e01cf367d$e926a6b0$bb73f410$%han@samsung.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Joe Perches' <joe@perches.com>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>

On Mon, Mar 03, 2014 at 10:14:22AM +0900, Jingoo Han wrote:
> On Wednesday, February 26, 2014 3:26 PM, Viresh Kumar wrote:
> > On 26 February 2014 10:49, Joe Perches <joe@perches.com> wrote:
> > > Look at warn_alloc_failed() in mm/page_alloc.c
> > 
> > Okay, there is a print there. But I am not able to reach to this routine
> > from devm_kzalloc().
> > 
> > devm_kzalloc() <linux/device.h>
> > devm_kmalloc() <drivers/base/devres.c>
> > alloc_dr() <drivers/base/devres.c>
> > kmalloc_track_caller() <linux/slab.h>
> > __kmalloc_track_caller() <mm/slab,slub/slob.c> Taking slab as example:
> > __do_kmalloc() <mm/slab.c>
> 
> (+CC Laurent Pinchart, Dan Carpenter)
> 
> Right, I also cannot find that warn_alloc_failed() is called, during 
> devm_kzalloc().
> 
> However, in the case of vmalloc(), warn_alloc_failed() is called
> as below.
> 
> ./mm/vmalloc.c
> vmalloc()
> __vmalloc_node_flags()
> __vmalloc_node()
> __vmalloc_node_range()
> 
> ./mm/page_alloc.c
> warn_alloc_failed()
> 
> > ...
> > 
> > I can see cases where NULL is returned after above paths and the function
> > you mentioned wasn't there. So, I am not sure that we will get a print for sure
> > for any error that might occur from devm_kzalloc().
> 
> I guess that slab_out_of_memory() <./mm/slub.c> may print it for any errors.
> But, I am not sure. :-(
> 

devm_kzalloc() is just kmalloc().  The OOM error messages are the same.

regards,
dan carpenter

