From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] pwm: spear: fix check on pwmchip_add() return value
Date: Wed, 7 May 2014 14:02:24 +0530
Message-ID: <CAKohpomkrR715dhyZZQwu_-S6LHsYBOj9YsX9HR6PCMKkMdrVw@mail.gmail.com>
References: <1399325340-20416-1-git-send-email-b.galvani@gmail.com>
	<CAOh2x=mWqa=p2d1kRjf0_37DiioJZOJm3Ewv2xpMrNjPy69rvA@mail.gmail.com>
	<20140507082410.GC6362@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:47583 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbaEGIcZ (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 7 May 2014 04:32:25 -0400
Received: by mail-oa0-f54.google.com with SMTP id j17so804213oag.27
        for <linux-pwm@vger.kernel.org>; Wed, 07 May 2014 01:32:25 -0700 (PDT)
In-Reply-To: <20140507082410.GC6362@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 May 2014 13:54, Thierry Reding <thierry.reding@gmail.com> wrote:
> So the current code would run clk_unprepare() on success, but not on
> failure. Does that cause any harm?

Yeah, that would make the device unusable  as clk_enable will always fail.

> Is the device still usable after this?

Yes, this will fix the bug.

> I'm asking because I'm not sure if this is linux-next material
> or should be a fix for 3.15 (and possibly backported to stable).

IMO, it should be sent for stable: v3.8+
