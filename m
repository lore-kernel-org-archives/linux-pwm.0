From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] dts: imx6: Allow flags argument in pwms reference
Date: Mon, 16 Mar 2020 08:55:37 +0800
Message-ID: <20200316005536.GF17221@dragon>
References: <20200309145558.16098-1-pbarker@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbgCPAzo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Mar 2020 20:55:44 -0400
Content-Disposition: inline
In-Reply-To: <20200309145558.16098-1-pbarker@konsulko.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Paul Barker <pbarker@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, Matt Ranostay <matt.ranostay@konsulko.com>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>

On Mon, Mar 09, 2020 at 02:55:58PM +0000, Paul Barker wrote:
> The pwm-imx27 driver supports a third argument in a pwms reference to
> provide flags. However #pwm-cells needs to be set to <3> in the pwm node
> so that these flags can be passed through to the driver. Once #pwm-cells
> is <3>, all pwms references need to use the 3-cell form.
> 
> Signed-off-by: Paul Barker <pbarker@konsulko.com>

'ARM: dts: imx6: ...' to be prefix please.

Shawn
