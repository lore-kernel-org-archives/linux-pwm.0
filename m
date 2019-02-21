From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/3] pwm: hibvt: Use individual struct per of-data.
Date: Thu, 21 Feb 2019 20:50:35 +0100
Message-ID: <20190221195035.jduvbbxn4t46qken@pengutronix.de>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219095808.12059-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 19, 2019 at 10:58:06AM +0100, Mathieu Othacehe wrote:
> Split pwm-soc array in one struct per soc and point to the
> corresponding on in of-data.
> 
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
