From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 1/1] pwm: samsung: avoid setting manual update bit
 unnecessarily
Date: Thu, 28 Nov 2013 14:44:14 +0100
Message-ID: <5465670.GCi1FFbjRb@amdc1227>
References: <1383108704-3297-1-git-send-email-sachin.kamat@linaro.org>
 <20131128132640.GA23201@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:13735 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3K1NoV (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Nov 2013 08:44:21 -0500
In-reply-to: <20131128132640.GA23201@ulmo.nvidia.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, tomasz.figa@gmail.com, Andrew Bresticker <abrestic@chromium.org>

On Thursday 28 of November 2013 14:26:41 Thierry Reding wrote:
> On Wed, Oct 30, 2013 at 10:21:44AM +0530, Sachin Kamat wrote:
> > From: Andrew Bresticker <abrestic@chromium.org>
> > 
> > When possible, avoid setting the manual update bit and starting/stopping
> > the PWM when adjusting the PWM as it causes noticable flickering when
> > setting the backlight brightness.
> > 
> > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/pwm/pwm-samsung.c |   23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> There has been no comment on this, so can I assume this is fine with
> everyone?

Oops. Seems like I missed this particular patch. Hold on a while,
I'm looking at it right now.

Best regards,
Tomasz

