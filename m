From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] pwm: spear: Remove unnecessary OOM messages
Date: Wed, 26 Feb 2014 11:56:20 +0530
Message-ID: <CAKohpokrSZiHAUoQggEnnYADUpE2DSBA0ECoUfPZPZFxTha3CA@mail.gmail.com>
References: <000701cf328e$00ed24c0$02c76e40$%han@samsung.com>
	<000d01cf328f$687d54b0$3977fe10$%han@samsung.com>
	<CAKohpo=xbZ4RNLDtdP3PokQwQksiKRBnuOTPL5z_zywwyOJC3w@mail.gmail.com>
	<000501cf32af$3ad0ecf0$b072c6d0$%han@samsung.com>
	<CAKohpon44tVo7K-tPQns1yfs4pBNy9-vY5UPocrHfSPbQ7M5_A@mail.gmail.com>
	<1393391957.407.1.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:61197 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbaBZG0X (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2014 01:26:23 -0500
Received: by mail-oa0-f51.google.com with SMTP id j17so393244oag.10
        for <linux-pwm@vger.kernel.org>; Tue, 25 Feb 2014 22:26:22 -0800 (PST)
In-Reply-To: <1393391957.407.1.camel@joe-AO722>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 26 February 2014 10:49, Joe Perches <joe@perches.com> wrote:
> Look at warn_alloc_failed() in mm/page_alloc.c

Okay, there is a print there. But I am not able to reach to this routine
from devm_kzalloc().

devm_kzalloc() <linux/device.h>
devm_kmalloc() <drivers/base/devres.c>
alloc_dr() <drivers/base/devres.c>
kmalloc_track_caller() <linux/slab.h>
__kmalloc_track_caller() <mm/slab,slub/slob.c> Taking slab as example:
__do_kmalloc() <mm/slab.c>
...

I can see cases where NULL is returned after above paths and the function
you mentioned wasn't there. So, I am not sure that we will get a print for sure
for any error that might occur from devm_kzalloc().
