From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 5 Mar 2014 14:40:06 +0300
Message-ID: <20140305114005.GA28102@mwanda>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <008e01cf367d$e926a6b0$bb73f410$%han@samsung.com>
 <20140303095311.GF27552@mwanda>
 <6028232.VHmxlGjlXi@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41523 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221AbaCELlD (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 06:41:03 -0500
Content-Disposition: inline
In-Reply-To: <6028232.VHmxlGjlXi@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Joe Perches' <joe@perches.com>, 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>

On Wed, Mar 05, 2014 at 12:00:42PM +0100, Laurent Pinchart wrote:
> Hi Dan,
> 
> On Monday 03 March 2014 12:53:11 Dan Carpenter wrote:
> > On Mon, Mar 03, 2014 at 10:14:22AM +0900, Jingoo Han wrote:
> > > On Wednesday, February 26, 2014 3:26 PM, Viresh Kumar wrote:
> > > > On 26 February 2014 10:49, Joe Perches <joe@perches.com> wrote:
> > > > > Look at warn_alloc_failed() in mm/page_alloc.c
> > > > 
> > > > Okay, there is a print there. But I am not able to reach to this routine
> > > > from devm_kzalloc().
> > > > 
> > > > devm_kzalloc() <linux/device.h>
> > > > devm_kmalloc() <drivers/base/devres.c>
> > > > alloc_dr() <drivers/base/devres.c>
> > > > kmalloc_track_caller() <linux/slab.h>
> > > > __kmalloc_track_caller() <mm/slab,slub/slob.c> Taking slab as example:
> > > > __do_kmalloc() <mm/slab.c>
> > > 
> > > (+CC Laurent Pinchart, Dan Carpenter)
> > > 
> > > Right, I also cannot find that warn_alloc_failed() is called, during
> > > devm_kzalloc().
> > > 
> > > However, in the case of vmalloc(), warn_alloc_failed() is called
> > > as below.
> > > 
> > > ./mm/vmalloc.c
> > > vmalloc()
> > > __vmalloc_node_flags()
> > > __vmalloc_node()
> > > __vmalloc_node_range()
> > > 
> > > ./mm/page_alloc.c
> > > warn_alloc_failed()
> > > 
> > > > ...
> > > > 
> > > > I can see cases where NULL is returned after above paths and the
> > > > function you mentioned wasn't there. So, I am not sure that we will get
> > > > a print for sure for any error that might occur from devm_kzalloc().
> > > 
> > > I guess that slab_out_of_memory() <./mm/slub.c> may print it for any
> > > errors. But, I am not sure. :-(
> > 
> > devm_kzalloc() is just kmalloc().  The OOM error messages are the same.
> 
> Sure, but I wasn't sure whether all error code paths in kmalloc() resulted in 
> an OOM message. For instance, the following code path results in an allocation 
> failure but doesn't seem to print an OOM message:
> 
> kmalloc
> __kmalloc
> __do_kmalloc
> slab_alloc
> slab_should_failslab
> should_failslab
> should_fail
> 
> A bit far-fetched possibly as it requires fault injection. I haven't found any 
> other such code path, but my understanding of that code is a bit limited.

should_fail() only returns true after calling fail_dump().

You can pass (GFP_KERNEL | __GFP_NOWARN) if you want to turn off
warnings.  Otherwise it shuold print a warning.

regards,
dan carpenter

