From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v3] pwm: add CSR SiRFSoC PWM driver
Date: Fri, 28 Feb 2014 22:33:02 +0800
Message-ID: <CAGsJ_4yV-Dju2n-z=nG+Z0dyfwUdpJBN=sYGKn5SVYtMbX--6A@mail.gmail.com>
References: <1391855002-26098-1-git-send-email-21cnbao@gmail.com>
 <lel46f$q2d$1@ger.gmane.org> <CAGsJ_4xLtXV6WtVhLgzFAaU9oG5UOt+LonFktBipQf_a6Yutng@mail.gmail.com>
 <CAMiSF3CczVV+Ob++_ACcwE+OXvFH8f9v1E=Q1F5x7Zz1BjCCzg@mail.gmail.com>
 <CAGsJ_4ywPTbUnfVVFFNFMSwG0CGckxKqHZ81rvEDFK-_1H25tA@mail.gmail.com>
 <CAMiSF3CN33N867TtjatYx1EwaV5qJY=JYsSrVFpQvC+yS1T5rA@mail.gmail.com>
 <CAGsJ_4z_48pZcXJXkwyuujoq=cEF3Oov5_GBRtHHOufMdEpRGA@mail.gmail.com>
 <CAGsJ_4yqznr4BAHdk5Hjm1X8BAsiWhMUSTRnriLvykVJ8-8dKw@mail.gmail.com>
 <CAMiSF3BFMpp4-LKdKouwmP6ca6nEQvu27LNGU6dAW4BX-dez=g@mail.gmail.com> <CAGsJ_4wcmTEa0F=ELFCqF-MrRzuabYRTR-uctwCXqUJ7gdWRjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:43339 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaB1OdX (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2014 09:33:23 -0500
Received: by mail-pd0-f177.google.com with SMTP id g10so795895pdj.8
        for <linux-pwm@vger.kernel.org>; Fri, 28 Feb 2014 06:33:23 -0800 (PST)
In-Reply-To: <CAGsJ_4wcmTEa0F=ELFCqF-MrRzuabYRTR-uctwCXqUJ7gdWRjw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

>
> i think what we can make everything clear is making the channel clocks
> become clock nodes of the whole clock tree, the node can be requested
> by a non-PWM device and PWM-channel through clk_get. if someone wants
> a clock, get it from clock subsystem, and the PWM channel here can
> request the clock as well. but i don't have plan to do that for the
> moment.
>
i am not sure whether i have described everything clear enough. the
point is if the bluetooth want a clock with 32KHz, it should want it
by clk_get(), but not get it from pwm_config. it is just a workaround.
the pwm is the concept of prima2 hardware, lcd can think it is asking
pwm, why is bluetooth thinking it is requesting a PWM? in the view of
bluetooth, the source is a clock not a PWM thing for backlight.

-barry
