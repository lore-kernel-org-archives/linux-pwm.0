From: Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [RESEND v6 1/2] pwm: Convert drivers to use 64-bit period and
 duty cycle
Date: Fri, 6 Mar 2020 10:56:59 -0800
Message-ID: <20200306185252.GA2758@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
 <28090aef9900ad483cbfbe77883e5ffcd8745907.1583177501.git.gurus@codeaurora.org>
 <20200306074440.ykekwwlvnbodxkjc@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6636 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgCFS5A (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 13:57:00 -0500
Content-Disposition: inline
In-Reply-To: <20200306074440.ykekwwlvnbodxkjc@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de

On Fri, Mar 06, 2020 at 08:44:40AM +0100, Uwe Kleine-König wrote:
> I guess we need acks from the affected maintainers. While I think the
> changes are fine I think you won't evade having to expand the audience
> of your patch and (depending on feedback) maybe split this patch up
> further.

Hi Uwe,

Sure. I'll split up this patch into one per file and add the respective
maintainers for ease of reviewing.

Thank you.

Guru Das.
