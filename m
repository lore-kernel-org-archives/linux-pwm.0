From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Thu, 6 Mar 2014 00:17:38 +0800
Message-ID: <CAKohponXNmXPZP2Umz3BfRnXyOPX5Fa9606Lc42ORnOuevifEw@mail.gmail.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
	<008e01cf367d$e926a6b0$bb73f410$%han@samsung.com>
	<20140303095311.GF27552@mwanda>
	<6028232.VHmxlGjlXi@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:38442 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbaCEQRi (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Mar 2014 11:17:38 -0500
Received: by mail-ob0-f180.google.com with SMTP id wn1so1223135obc.11
        for <linux-pwm@vger.kernel.org>; Wed, 05 Mar 2014 08:17:38 -0800 (PST)
In-Reply-To: <6028232.VHmxlGjlXi@avalon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Jingoo Han <jg1.han@samsung.com>, Joe Perches <joe@perches.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 5 March 2014 19:00, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
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

In that case should we actually accept patches like this at all? As they
might be ending up removing some useful print messages?
