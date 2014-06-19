From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
Date: Thu, 19 Jun 2014 11:12:36 +0100
Message-ID: <20140619101236.GA7390@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
 <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
 <20140619092042.GB26560@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:37177 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbaFSKMl (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Jun 2014 06:12:41 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so2094778wes.4
        for <linux-pwm@vger.kernel.org>; Thu, 19 Jun 2014 03:12:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140619092042.GB26560@lee--X1>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, thierry.reding@gmail.com

Hi Lee,

> > Why are you only enabling this for rev-E board?
> 
> Purely for testing purposes, as it's the only board I have.  If
> anyone has the other revisions and would be happy to test the driver
> for me then great.

Ok that's what I suspected.

If you tell me how, I can test on a Rev C board. But as there are several other 
revisions I think checking the board schematics would be the quickest way forward.

> > If you make the stih415 DT PWM nodes part of this series as well, then 
> > assuming there is no good reason to the contary, the PWM could 
> > be enabled for both stih415/6 in the common stih41x-b2020 DTS file which
> > is also included by rev-E (assuming that PWM wiring is not some rev-E specific
> > thing).

Can you add the stih415 bindings in V2 as well?

regards,

Peter
