From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] docs: pwm: rework documentation for the framework
Date: Wed, 29 Jan 2020 10:24:18 +0100
Message-ID: <20200129092418.a7vbz37uzloyfmdc@pengutronix.de>
References: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
 <20191209213233.29574-2-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37659 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JYT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jan 2020 04:24:19 -0500
Content-Disposition: inline
In-Reply-To: <20191209213233.29574-2-u.kleine-koenig@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de

Hello Thierry,

On Mon, Dec 09, 2019 at 10:32:33PM +0100, Uwe Kleine-König wrote:
> Rewrite most of the documentation to have the focus on the atomic API
> and mention the legacy stuff only shortly.
> 
> The paragraphs about Locking and Helpers is dropped as they mostly
> describe development outlooks which didn't happen yet (since the promise
> to fix stuff "soon" was introduced in 2011).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Do you have feedback for this patch? IMHO it's a good improvement as it
discards the stuff about the legacy API (only mentioning it at the end)
and concentrates about the stuff that is currently the way to go.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
