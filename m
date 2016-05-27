From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] pwm: don't allow duty cycle higher than period
Date: Fri, 27 May 2016 09:39:43 -0700
Message-ID: <20160527163943.GB80118@google.com>
References: <1464296730-121773-1-git-send-email-briannorris@chromium.org>
 <20160527093439.5ad237c5@bbrezillon>
 <20160527163533.GA80118@google.com>
 <20160527183814.6f8f4ba7@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35360 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbcE0Qjq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 27 May 2016 12:39:46 -0400
Received: by mail-pf0-f174.google.com with SMTP id g64so43508970pfb.2
        for <linux-pwm@vger.kernel.org>; Fri, 27 May 2016 09:39:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160527183814.6f8f4ba7@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Doug Anderson <dianders@chromium.org>

On Fri, May 27, 2016 at 06:38:14PM +0200, Boris Brezillon wrote:
> On Fri, 27 May 2016 09:35:33 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, May 27, 2016 at 09:34:39AM +0200, Boris Brezillon wrote:
> > Now that you mention it, I think you've also dropped some signed
> > (negative value) checking in pwm_config(). I'll squash in your diff +
> > some pwm_config() fixes.
> 
> ->period and ->duty_cycle are unsigned now ;).

Not in pwm_config(). And we don't want to implitly make thos into large
unsigned values.

Brian
