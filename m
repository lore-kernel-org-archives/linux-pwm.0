From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH INTERNAL v2 1/3] Documentation: dt: Add Broadcom iproc pwm
 controller binding
Date: Wed, 18 May 2016 16:04:32 -0700
Message-ID: <573CF500.5070708@broadcom.com>
References: <1463554441-47982-1-git-send-email-yendapally.reddy@broadcom.com>
 <1463554441-47982-2-git-send-email-yendapally.reddy@broadcom.com>
 <20160518221546.GA32596@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34499 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcERXEp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2016 19:04:45 -0400
Received: by mail-pf0-f175.google.com with SMTP id y69so22967631pfb.1
        for <linux-pwm@vger.kernel.org>; Wed, 18 May 2016 16:04:45 -0700 (PDT)
In-Reply-To: <20160518221546.GA32596@rob-hp-laptop>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Russell King <linux@arm.linux.org.uk>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org

Hi Rob,

On 16-05-18 03:15 PM, Rob Herring wrote:
> Am I supposed to ignore since this is "internal"?
The "INTERNAL" was supposed to be removed after internal review before 
sending out to the public mailing list.

Also, Yendapally's git email config was not setup properly so some are 
tagging the patchset as spam.

Other than that, everything is fine with the PATCH sent out to the open 
source community :)

I'm sure Yendapally will send out an updated version with those items 
corrected (and can add your Acked-by now).

Thanks,
  Scott

>
> On Wed, May 18, 2016 at 02:53:59AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
>> Add a binding for Broadcom iproc pwm controller
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
>> ---
>>   .../devicetree/bindings/pwm/brcm,iproc-pwm.txt      | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pwm/brcm,iproc-pwm.txt
>
> Acked-by: Rob Herring <robh@kernel.org>
>
