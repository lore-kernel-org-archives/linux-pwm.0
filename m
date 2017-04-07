From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2] ARM: at91: Document new TCB bindings
Date: Fri, 7 Apr 2017 14:31:32 +0200
Message-ID: <20170407123132.ety26gj7sak5lr6t@piout.net>
References: <1467039901-11297-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160701012743.GA16698@rob-hp-laptop>
 <20160704151058.44b679bf@bbrezillon>
 <CAL_JsqL2Kjtf-BuCjK8ZHcDdbgVDy-L-_AN+=4HmxVAwy3ucdA@mail.gmail.com>
 <20170125161129.41acaa9a@bbrezillon>
 <fd4a2797-d8eb-ac80-36fc-01240fb0e944@atmel.com>
 <a8d541f0-e70a-a12d-5a7e-b1b72eddbe65@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39467 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbdDGMbf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Apr 2017 08:31:35 -0400
Content-Disposition: inline
In-Reply-To: <a8d541f0-e70a-a12d-5a7e-b1b72eddbe65@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 07/04/2017 at 14:15:36 +0200, Daniel Lezcano wrote:
> >> What's your solution for this case?
> > 
> > It seems that we don't have any progress on this topic for more than 6
> > months which is a pity as we now experience an issue that would have
> > been addressed completely by the TC rework [1].
> > 
> > aka "ping"... ;-)
> 
> 
> Hi Nicolas, Boris,
> 
> is there any news from your side ?
> 

I'm planning to resubmit news bindings and the full rework when I'll
have time to work on that. But I must admit I don't quite see the issue
with the proposed bindings.

Also, we are starting to see more and more flexible timer IPs that can
be used as RTC, timer, pwm, counters, quad decoders. I'm starting to
think we may need a new subsystem.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
