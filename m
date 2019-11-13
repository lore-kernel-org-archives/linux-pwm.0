Return-path: <kernel-bounces@pengutronix.de>
Date: Wed, 13 Nov 2019 14:43:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20191113144309.54b19011@gandalf.local.home>
In-Reply-To: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
References: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: implement tracing for .get_state() and .apply_state()
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/cgi-bin/mailman/private/kernel/>
List-Post: <mailto:kernel@pengutronix.de>
List-Help: <mailto:kernel-request@pengutronix.de?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/kernel>, 
 <mailto:kernel-request@pengutronix.de?subject=subscribe>
Errors-To: kernel-bounces@pengutronix.de
Sender: "kernel" <kernel-bounces@pengutronix.de>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

On Thu, 24 Oct 2019 10:08:29 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> This allows to log all calls to the driver's lowlevel functions which
> simplifies debugging in some cases.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I didn't add a trace call to .get_state added in=20
> 01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented state=
")
> in the expectation that this will be reverted very soon anyhow and
> addint it there would only complicate reverting (or applying this
> patch).
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/core.c         |  9 +++++-
>  include/trace/events/pwm.h | 58 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/pwm.h
>=20
>

=46rom the tracing point of view:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
