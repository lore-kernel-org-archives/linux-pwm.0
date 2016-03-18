From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH] pwm: add support for freq_hz and duty_percent
Date: Fri, 18 Mar 2016 11:55:54 +0200
Message-ID: <56EBD0AA.40309@mentor.com>
References: <1458294195-24538-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
 <1458294195-24538-2-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:50403 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcCRJz5 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Mar 2016 05:55:57 -0400
In-Reply-To: <1458294195-24538-2-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: wan.ahmad.zainie.wan.mohamad@intel.com, thierry.reding@gmail.com
Cc: linux-pwm@vger.kernel.org

On 18.03.2016 11:43, wan.ahmad.zainie.wan.mohamad@intel.com wrote:
> From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> 
> Add new sysfs interface, freq_hz and duty_percent, together with their
> helper functions to the PWM framework. This patch will enable the
> duration to be configured in unit Hertz and the "on" duration to be
> configured as percentage.

What's your motivation? Can you do the calculations in userspace?

I personally dislike an idea of having multiple ways/interfaces to do
the same thing.

> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---

--
With best wishes,
Vladimir
