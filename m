Return-path: <kernel-bounces@pengutronix.de>
Date: Mon, 11 Nov 2019 10:16:06 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before
 making it unfunctional
Message-ID: <20191111091606.qf7gj5gln3khfnsl@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Neil Brown <neilb@suse.de>, kernel-janitors@vger.kernel.org, kernel@pengutronix.de, Markus Elfring <elfring@users.sourceforge.net>
List-ID: <linux-pwm.vger.kernel.org>

Hello,

I created a cover letter but failed to send it together with the series
:-|

It said:

| I promised a cleanup patch but as I found a few more issues I have four
| patches now. The third patch replaces Markus' patch with a more complete
| fix that also drops the reference in .remove not only the error path of
| .probe.
|=20
| The last patch allows to compile the driver in more configurations, it
| compiled successfully on amd64 and arm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
