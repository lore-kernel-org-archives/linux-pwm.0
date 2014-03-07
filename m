From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Fri, 07 Mar 2014 17:04:36 +0900
Message-ID: <005801cf39db$e1a37240$a4ea56c0$%han@samsung.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
 <6028232.VHmxlGjlXi@avalon>
 <CAKohponXNmXPZP2Umz3BfRnXyOPX5Fa9606Lc42ORnOuevifEw@mail.gmail.com>
 <24037035.nXcZgi4Mc2@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28924 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbaCGIEj (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Mar 2014 03:04:39 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N22003AK3RO0K80@mailout4.samsung.com> for
 linux-pwm@vger.kernel.org; Fri, 07 Mar 2014 17:04:36 +0900 (KST)
In-reply-to: <24037035.nXcZgi4Mc2@avalon>
Content-language: ko
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: 'Thierry Reding' <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: 'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Joe Perches' <joe@perches.com>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, March 06, 2014 1:30 AM, Laurent Pinchart wrote:
> On Thursday 06 March 2014 00:17:38 Viresh Kumar wrote:
> > On 5 March 2014 19:00, Laurent Pinchart wrote:
> > > Sure, but I wasn't sure whether all error code paths in kmalloc() resulted
> > > in an OOM message. For instance, the following code path results in an
> > > allocation failure but doesn't seem to print an OOM message:
> > >
> > > kmalloc
> > > __kmalloc
> > > __do_kmalloc
> > > slab_alloc
> > > slab_should_failslab
> > > should_failslab
> > > should_fail
> > >
> > > A bit far-fetched possibly as it requires fault injection. I haven't found
> > > any other such code path, but my understanding of that code is a bit
> > > limited.
> >
> > In that case should we actually accept patches like this at all? As they
> > might be ending up removing some useful print messages?
> 
> Dan has pointed out that I've missed the fail_dump() call in should_fail().
> One could argue that fail_dump() wouldn't print any message if the fault
> injection framework has verbosity set to 0, but I suppose we can assume that
> people using the fault injection framework know what they're doing.
> 
> All other error paths in kmalloc() seem to result in a message being printed.
> I might have missed something, but I can trust the developers who know that
> code much better than I do that kmalloc() is designed to print an error
> message in all error paths. Any failure to print a message would be a
> kmalloc() bug that should be fixed, and getting rid of the allocation error
> messages in drivers would seem like a nice cleanup to me.

Hi Thierry Reding,

There seems to be no objection. :-)
Would you accept these patches?
Thank you.

Best regards,
Jingoo Han

