From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Mon, 03 Mar 2014 10:14:22 +0900
Message-ID: <008e01cf367d$e926a6b0$bb73f410$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
 <CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
 <000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
 <CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
 <1393391957.407.1.camel@joe-AO722>
 <CAKohpokrSZiHAUoQggEnnYADUpE2DSBA0ECoUfPZPZFxTha3CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22400 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaCCBOb (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Mar 2014 20:14:31 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1U006KK63ZBX10@mailout2.samsung.com> for
 linux-pwm@vger.kernel.org; Mon, 03 Mar 2014 10:14:23 +0900 (KST)
In-reply-to: <CAKohpokrSZiHAUoQggEnnYADUpE2DSBA0ECoUfPZPZFxTha3CA@mail.gmail.com>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Joe Perches' <joe@perches.com>
Cc: 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Wednesday, February 26, 2014 3:26 PM, Viresh Kumar wrote:
> On 26 February 2014 10:49, Joe Perches <joe@perches.com> wrote:
> > Look at warn_alloc_failed() in mm/page_alloc.c
> 
> Okay, there is a print there. But I am not able to reach to this routine
> from devm_kzalloc().
> 
> devm_kzalloc() <linux/device.h>
> devm_kmalloc() <drivers/base/devres.c>
> alloc_dr() <drivers/base/devres.c>
> kmalloc_track_caller() <linux/slab.h>
> __kmalloc_track_caller() <mm/slab,slub/slob.c> Taking slab as example:
> __do_kmalloc() <mm/slab.c>

(+CC Laurent Pinchart, Dan Carpenter)

Right, I also cannot find that warn_alloc_failed() is called, during 
devm_kzalloc().

However, in the case of vmalloc(), warn_alloc_failed() is called
as below.

./mm/vmalloc.c
vmalloc()
__vmalloc_node_flags()
__vmalloc_node()
__vmalloc_node_range()

./mm/page_alloc.c
warn_alloc_failed()

> ...
> 
> I can see cases where NULL is returned after above paths and the function
> you mentioned wasn't there. So, I am not sure that we will get a print for sure
> for any error that might occur from devm_kzalloc().

I guess that slab_out_of_memory() <./mm/slub.c> may print it for any errors.
But, I am not sure. :-(

Joe Perches,
Would you confirm this?

Best regards,
Jingoo Han

