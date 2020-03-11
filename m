From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
Date: Wed, 11 Mar 2020 17:44:49 +0100
Message-ID: <20200311164449.flzzwxqqhcxisil3@pengutronix.de>
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37493 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgCKQov (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 12:44:51 -0400
Content-Disposition: inline
In-Reply-To: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Rishi Gupta <gupt21@gmail.com>
Cc: thierry.reding@gmail.com, s.trumtrar@pengutronix.de, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:13:49PM +0530, Rishi Gupta wrote:
> The __maybe_unused attribute is preferred over CONFIG_PM
> to prevent build time issues. This commit replaces CONFIG_PM
> with this attribute.

I wasn't aware of build time issues and thought this was just about
#ifdef being ugly.

Anyhow, the change is fine,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
