From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 2/2] backlight: pwm: clean up pwm requested using legacy
 API
Date: Fri, 7 Nov 2014 00:10:25 +0200
Message-ID: <545BF1D1.30304@mentor.com>
References: <1413035186-11771-1-git-send-email-vladimir_zapolskiy@mentor.com> <1413035186-11771-3-git-send-email-vladimir_zapolskiy@mentor.com> <20141011142156.GC11456@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62345 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaKFWKf (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Nov 2014 17:10:35 -0500
In-Reply-To: <20141011142156.GC11456@kroah.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>

Hello Greg, Thierry,

On 11.10.2014 17:21, Greg KH wrote:
> On Sat, Oct 11, 2014 at 04:46:26PM +0300, Vladimir Zapolskiy wrote:
>> If PWM device is requested by means of legacy API pwm_request(), its
>> resources are not freed on module unbind, which may cause an oops on
>> access, e.g. by reading /sys/kernel/debug/pwm.
>>
>> Reported-by: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c |    4 ++++
>>  1 file changed, 4 insertions(+)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>
> --

could you please review the change? I believe it would be nice to have
oops fix in v3.18.

--
With best wishes,
Vladimir
