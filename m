From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 05 Mar 2014 17:29:55 +0100
Message-ID: <24037035.nXcZgi4Mc2@avalon>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com> <6028232.VHmxlGjlXi@avalon> <CAKohponXNmXPZP2Umz3BfRnXyOPX5Fa9606Lc42ORnOuevifEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38997 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbaCEQ22 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 11:28:28 -0500
In-Reply-To: <CAKohponXNmXPZP2Umz3BfRnXyOPX5Fa9606Lc42ORnOuevifEw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Jingoo Han <jg1.han@samsung.com>, Joe Perches <joe@perches.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Hi Viresh,

On Thursday 06 March 2014 00:17:38 Viresh Kumar wrote:
> On 5 March 2014 19:00, Laurent Pinchart wrote:
> > Sure, but I wasn't sure whether all error code paths in kmalloc() resulted
> > in an OOM message. For instance, the following code path results in an
> > allocation failure but doesn't seem to print an OOM message:
> > 
> > kmalloc
> > __kmalloc
> > __do_kmalloc
> > slab_alloc
> > slab_should_failslab
> > should_failslab
> > should_fail
> > 
> > A bit far-fetched possibly as it requires fault injection. I haven't found
> > any other such code path, but my understanding of that code is a bit
> > limited.
>
> In that case should we actually accept patches like this at all? As they
> might be ending up removing some useful print messages?

Dan has pointed out that I've missed the fail_dump() call in should_fail(). 
One could argue that fail_dump() wouldn't print any message if the fault 
injection framework has verbosity set to 0, but I suppose we can assume that 
people using the fault injection framework know what they're doing.

All other error paths in kmalloc() seem to result in a message being printed. 
I might have missed something, but I can trust the developers who know that 
code much better than I do that kmalloc() is designed to print an error 
message in all error paths. Any failure to print a message would be a 
kmalloc() bug that should be fixed, and getting rid of the allocation error 
messages in drivers would seem like a nice cleanup to me.

-- 
Regards,

Laurent Pinchart

