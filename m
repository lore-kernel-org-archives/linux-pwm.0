From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] pwm: spear: fix check on pwmchip_add() return value
Date: Wed, 7 May 2014 14:23:06 +0530
Message-ID: <CAKohpomnACpPFytPWDQeeUTRM3yoNPPOHbWQLpsVjF=V_qVm1Q@mail.gmail.com>
References: <1399325340-20416-1-git-send-email-b.galvani@gmail.com>
	<CAOh2x=mWqa=p2d1kRjf0_37DiioJZOJm3Ewv2xpMrNjPy69rvA@mail.gmail.com>
	<20140507082410.GC6362@ulmo>
	<CAKohpomkrR715dhyZZQwu_-S6LHsYBOj9YsX9HR6PCMKkMdrVw@mail.gmail.com>
	<20140507084900.GE6362@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57838 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbaEGIxH (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 7 May 2014 04:53:07 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so826231oag.32
        for <linux-pwm@vger.kernel.org>; Wed, 07 May 2014 01:53:06 -0700 (PDT)
In-Reply-To: <20140507084900.GE6362@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 May 2014 14:19, Thierry Reding <thierry.reding@gmail.com> wrote:
> Since this was obviously broken since 3.8 and nobody noticed I wonder if
> there's really an urgent need for this in stable.

I don't think there is any urgent need of this, in case somebody wants we
can add it later. :)
