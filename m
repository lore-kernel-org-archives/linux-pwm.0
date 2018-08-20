Return-path: <kernel-bounces@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] specify the pin state after pwm_disable as explicitly
 undefined
Date: Mon, 20 Aug 2018 16:43:55 +0200
Message-Id: <20180820144357.7206-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
References: <20180820095221.fydcvtz7ppcymrta@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linux-pwm@vger.kernel.org, Gavin Schenk <g.schenk@eckelmann.de>, kernel@pengutronix.de
List-ID: <linux-pwm.vger.kernel.org>

Hello Thierry,

these would be the first two patches I'd suggest after you fail to find
an example that shows a disadvantage of my suggestion. :-)

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: document the pin state after pwm_disable() to be undefined
  pwm: warn callers of pwm_apply_state() that expect a certain level
    after disabling

 Documentation/pwm.txt |  8 ++++++--
 drivers/pwm/core.c    | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.18.0
