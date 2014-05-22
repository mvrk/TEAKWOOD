__author__ = 'wuyi'

import datetime

def delta_interval(queue, available_time_interval):
    remove_list = []
    for q in queue:
        for t in available_time_interval:
            if q['end'] < t['start']:
                pass
            elif q['start'] < t['start']:
                if q['end'] < t['end']:
                    q['end'] = t['start']
                elif q['end'] >= t['end']:
                    queue.append({'start':t['end'], 'end':q['end']})
                    q['end'] = t['start']
            elif q['start'] >= t['start'] and q['start'] < t['end']:
                if q['end'] < t['end']:
                    remove_list.append(q)
                    break
                elif q['end'] >= t['end']:
                    q['start'] = t['end']
            elif q['start'] >= t['end']:
                pass
            else:
                print "unexpected case"

    result = [ elem for elem in queue if elem not in remove_list ]
    return result


if __name__ == '__main__':
    available_time_interval = [
        {'start':datetime.datetime(2010, 9, 1, 00, 00, 00), 'end':datetime.datetime(2010, 9, 2, 00, 00, 00)},
        {'start':datetime.datetime(2010, 9, 3, 00, 00, 00), 'end':datetime.datetime(2010, 9, 4, 00, 00, 00)}
    ]

    queue = [
        {'start':datetime.datetime(2010, 9, 1, 12, 00, 00), 'end':datetime.datetime(2010, 9, 1 , 14, 00, 00)},
        {'start':datetime.datetime(2010, 8, 1, 0, 00, 00), 'end':datetime.datetime(2010, 9, 1 , 14, 00, 00)},
    ]

    delta = delta_interval(queue, available_time_interval)
    print delta