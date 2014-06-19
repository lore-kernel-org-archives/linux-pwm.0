From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [PATCH 4/7] ARM: stih416-b2020e: Enable PWM on
 the B2020 Rev-E
Date: Thu, 19 Jun 2014 10:05:46 +0100
Message-ID: <20140619090546.GB2131@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1403103172-19856-1-git-send-email-lee.jones@linaro.org>
 <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:59147 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbaFSJFv (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Jun 2014 05:05:51 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so2041519wev.34
        for <linux-pwm@vger.kernel.org>; Thu, 19 Jun 2014 02:05:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1403103172-19856-4-git-send-email-lee.jones@linaro.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, devicetree@vger.kernel.org, srinivas.kandagatla@gmail.com, thierry.reding@gmail.com

Hi Lee,

> All the infrastructure is now in place for ST's PWM controller.  This
> patch takes the final step and enables the IP on the 2020 Rev-E
> development platform.

Why are you only enabling this for rev-E board?

If you make the stih415 DT PWM nodes part of this series as well, then 
assuming there is no good reason to the contary, the PWM could 
be enabled for both stih415/6 in the common stih41x-b2020 DTS file which
is also included by rev-E (assuming that PWM wiring is not some rev-E specific
thing).

Also Ajit Signed-off-by needs adding to this series.

After that:
Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
