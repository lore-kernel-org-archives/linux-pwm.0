Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from www3345.sakura.ne.jp ([49.212.235.55]:27853 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfE1BKm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 May 2019 21:10:42 -0400
References: <1558923757-9843-1-git-send-email-cv-dong@jinso.co.jp>
 <20190527141741.GC7202@ulmo>
From: Cao Van Dong <cv-dong@jinso.co.jp>
Message-ID: <bbc7a187-d1ad-2ba5-0ee1-e241461faca5@jinso.co.jp>
Date: Tue, 28 May 2019 10:10:39 +0900
MIME-Version: 1.0
In-Reply-To: <20190527141741.GC7202@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
Subject: Re: [PATCH v5] pwm: renesas-tpu: Add suspend/resume function
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, horms+renesas@verge.net.au, geert+renesas@glider.be, broonie@kernel.org, linux-pwm@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com, kuninori.morimoto.gx@renesas.com, h-inayoshi@jinso.co.jp, na-hoan@jinso.co.jp

Dear Thierry-san,

Thank for your feedback!

> This has been discussed before, but this really shouldn't be done in the
> PWM driver. Consumers should really be reconfiguring the PWM upon resume
> as appropriate. This is the only way to ensure that everything is
> resumed in the proper order.
>
> Most, if not all, consumers already implement suspend/resume that way.
> sysfs is the only one that I'm aware of that doesn't.
>
> Since you've been using sysfs to test this, things are slightly more
> complicated (i.e. we don't have a consumer driver in the conventional
> way). However, you should be able to solve this by implementing
> dev_pm_ops for the pwm_class.
>
> Do you think you could give that a try?

I understood the problem. Really this is difficult with me.
Therefore, I will just stop here.

Thank you,
Dong

> Thierry
>
